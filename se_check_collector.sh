#!/bin/bash

## -c check CollectorData By serverToken
collectorData="QOfB2Xq69pndorTXdVL7shV5OEHen1Ru+lk87yuXyJw37EZXW3kcVNlDPTBB7gLdb72wDjINdGeyU8hShpG/xg9UbctWAT/Vp6JH6/7ULUxUDODF9Z2P1QukRCt60KMytxd3+Xp7oRDJNhd61/8KiqVaB6WbJnS4eDt2KSBImWXIdQGskuWEVLqYGhiU96uqYE7GGc3fvbmVKCxWOgKmz6t296Aq0whr9ZTkMPVZOGwGMirKAYPH5GRn6yUMA3YOMAxI6VgtdqqZ61RSulPofKujPIp+gEhj/2W3VAfzauj8+dgTPsTN9+OHCrF/+gZiMOU5conOcIVMcDhsWAHgpz+ksJuXGi3o/jfy5lFMG15j+3malUW2lU9ll2mHfksfvMsZNr0zAtEfykWpjxpyLXN0c2NmqwHzkG1e1OYL4fM54soBrzG4AKk72QKBgZBsxVtQS96yGdTY9CGMFpXUeO6vy30IETKw4uZrT/PGtrsgTi3ZfJaYg5mAHehv11TDGaFZ8i2nk25UQY/J7vfjWZLDvcNh0nK2uijfOwgiKFdMyg1epDEdAprTIqVmOfK6FH0vHAsG2cpvF0PLnPD2omzjPLFtb433g/Fc3OVbFuXFlnjfTqtSi31FAZd+I5EpQhTQ8iss8jRjEJvqdvk9iMRKn+3VDViWiJA4IElxVEOswu7z40OtiuFUEjwYoP8M9iEiQhtB3qxKfX3imzVFeLiZae+BEMv6JoBVCg05txWCbIiGKSstBfPEjrx/g9fGYizSgLeaGNxaaFQD7ClAobneXuEoNaoXCAsn9mrBYKgTHC3P4PSjZEt15hsQk97UpQ=="

serverToken="CiRwUWJHcys3Y3VoYmJ1SDN0TytKWEt5a0s3MDZSL3hYdC9nPT0="

./serverManager_mac -c -l "$serverToken" -t "$collectorData"
