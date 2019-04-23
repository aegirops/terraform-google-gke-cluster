#!/usr/bin/env bash

# Copyright 2019 Jetstack Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make the zonal cluster resource definiton from the regional cluster resource
# definition. This helps to keep the two definitions the same, except for the
# presence of the region or zone property.

set -e

cd example/
# Comment out the requirement for a GCS backend so we can init and validate locally
sed -i.bak 's|backend "gcs" {}|# backend "gcs" {}|g' main.tf
# Use the example tfvars
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
# Reset the GCS backend requirement
sed -i.bak 's|# backend "gcs" {}|backend "gcs" {}|g' main.tf
rm main.tf.bak
rm terraform.tfvars
rm -rf .terraform/
cd ..