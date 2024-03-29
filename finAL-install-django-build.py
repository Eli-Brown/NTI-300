#!/usr/bin/python

# This should be run from the Google cloud shell
# final-cloud-django-py must be in the same directory

from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_default()
compute = discovery.build('compute','v1', credentials=credentials)

project = 'cogent-genre-254202'
zone = 'us-west1-a'
name = 'django-final'

def list_instances(compute,project,zone):
  result = compute.instances().list(project=project,zone=zone).execute()
  return result['items']
  
def create_instance(compute,project,zone,name):
 startup_script = open('final-cloud-django-py','r').read()
 image_response = compute.images().getFromFamily(
   project = 'centos-cloud', family = 'centos-7').execute()
 
 source_disk_image = image_response['selfLink']
 machine_type = "zones/%s/machineTypes/f1-micro" % zone
 
 config = {
  'name' : name,
  'machineType' : machine_type,
  # Specify the boot disk and image to use as a source.
  'disks': [
    {
      'boot': True,
      'autoDelete': True,
      'initializeParams': {
        'sourceImage': source_disk_image,
      }
    }
  ],
  
  # Specify a network interface with NAT to access the public internet.
  'networkInterfaces': [{
    'network': 'global/networks/default',
    'accessConfigs': [
      {'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
    ]
  }],
  
  # Allow the instance to access cloud storage and logging.
  'serviceAccounts': [{
    'email': 'default',
    'scopes': [
      'https://www.googleapis.com/auth/devstorage.read_write',
      'https://www.googleapis.com/auth/logging.write'
    ]
  }],
  
  # Enablle http/https for select instances
  "labels": {
    "http-server": "",
    "https-server": ""
  },
  
  "tags": {
    "items": [
      "http-server",
      "https-server"
    ]
  },
  
  # Metadata is readable from the instances and allows you to pass configuration from deployment scripts to instances.
  'metadata': {
    'items': [{
      # Startup scrip is automatically executed by the instance up startup.
      'key': 'startup-script',
      'value': startup_script
    }]
  }
 }
 
 return compute.instances().insert(
  project=project,
  zone=zone,
  body=config).execute()

newinstance = create_instance(compute,project,zone,name)
instances = list_instances(compute,project,zone)

pprint.pprint(newinstance)
pprint.pprint(instances)
