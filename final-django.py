#!/usr/bin/python

#this should be run from the google cloud shell
#please substitute your project and zone in the project and zone vars
#use django.py

from oauth2client.client import GoogleCredentials
from googleapiclient import discovery
import pprint
import json

credentials = GoogleCredentials.get_application_default()
compute = discovery.build('compute', 'v1', credentials=credentials)

project = 'cogent-genre-254202'
zone = 'us-central1-a'
name = 'go-django-final'

def list_instances(compute, project, zone):
  result = compute.instances().list(project=project, zone=zone).execute()
  return result['items']
  
def create_instance(compute, project, zone, name):
    startup_script = open('django.py', 'r').read()
    image_response = compute.images().getFromFamily(
      project='centos-cloud', family='centos-7').execute()
    
    source_disk_image = image_response['selfLink']
    machine_type = "zones/%s/machineTypes/f1-micro" % zone

    config = {
        'name': name, 
        'machineType': machine_type,
  
        # Specify the boot disk and the image to use as a source.
        'disks': [
            {
                'boot': True,
                'autoDelete': True,
                'initializeParams': {
                    'sourceImage': source_disk_image,
               }
            }
        ],
  
        # Specify a network interface with NAT to access the public
        # internet.
        'networkInterfaces': [{
            'network': 'global/networks/default',
