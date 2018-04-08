#!/bin/bash

set -x

apt-get --yes --quiet update
apt-get --yes --quiet install puppet-common

#update-ca-certificates

# Copy puppet configuration
rm -rf /etc/puppet
cp -r puppet /etc

# Update libraries
ldconfig

# Run puppet
cd /etc/puppet/develop
puppet apply --verbose develop.pp 2>&1 | tee /var/log/puppet-apply.log

# Update libraries
ldconfig
