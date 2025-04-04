#!/bin/bash

delete_volume() {                                                     # Function to delete volumes
    vols=$(aws ec2 describe-volumes | jq -r ".Volumes[].VolumeId" -r) # Lists all the volumes in the region and stores the Volume-ID's in a variable

    for vol in $vols; do                                          # Loops through each volume in the region
        volume_info=$(aws ec2 describe-volumes --volume-ids $vol) # Gets the information of the volume
        size=$(echo $volume_info | jq -r ".Volumes[0].Size")
        state=$(echo $volume_info | jq -r ".Volumes[0].State")

        if [ "$state" == "in-use" ]; then
            echo "$vol is attached to an instance. Skipping deletion."
        elif [ "$size" -gt 5 ]; then
            echo "$vol is larger than 5GB. Skipping deletion."
        else
            echo "Deleting volume $vol..."
            aws ec2 delete-volume --volume-id $vol
        fi
    done
}

delete_volume
