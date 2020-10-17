#!/usr/bin/python

import sys
import os
import argparse
import python_terraform
import json

current_path = os.path.dirname(os.path.realpath(__file__))
project_path = os.path.dirname(os.path.dirname(os.path.dirname(current_path)))

python3 = '/usr/bin/python3'

parser = argparse.ArgumentParser(description='Expecting a --list argument')
parser.add_argument('--list', help='Return json config', action="store_true")
args = parser.parse_args()

if args.list:
    result = dict()
    t = python_terraform.Terraform(working_dir=os.path.join(project_path, 'terraform', 'prod'))
    output = t.output(json=True)

    external_ip_address_app = output['external_ip_address_app']['value']
    external_ip_address_db = output['external_ip_address_db']['value']
    internal_ip_address_db = output['internal_ip_address_db']['value']
    reddit_app_port = output['reddit_app_port']['value']

    result = {
        '_meta': {
            'hostvars': {
                external_ip_address_app: {
                    'ansible_python_interpreter': python3,
                    'internal_ip_address_db': internal_ip_address_db,
                    'reddit_app_port': reddit_app_port
                },
                external_ip_address_db: {
                    'ansible_python_interpreter': python3
                }
            }
        },
        'app': {
            'children': [
                'appserver'
            ]
        },
        'db': {
            'children': [
                'dbserver'
            ]
        },
        'appserver': {
            'hosts': [
                external_ip_address_app
            ]
        },
        'dbserver': {
            'hosts': [
                external_ip_address_db
            ]
        }
    }

    res_string = json.dumps(result, sort_keys=True, indent=4, separators=(',', ': '))

    print(res_string)

    exit(0)

else:
    print 'No --list argument was provided'
    exit(-1)
