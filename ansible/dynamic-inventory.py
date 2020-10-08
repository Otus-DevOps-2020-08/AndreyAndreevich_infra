#!/usr/bin/python

import sys
import os
import argparse
import python_terraform
import json

current_path = os.path.dirname(os.path.realpath(__file__))
project_path = os.path.dirname(current_path)

python3 = '/usr/bin/python3'
inventory_file = 'inventory.json'

parser = argparse.ArgumentParser(description='Expecting a --list argument')
parser.add_argument('--list', help='Return json config', action="store_true")
args = parser.parse_args()

if args.list:
    result = dict()
    t = python_terraform.Terraform(working_dir=os.path.join(project_path, 'terraform', 'prod'))
    output = t.output(json=True)

    app_addr = output['external_ip_address_app']['value']
    db_addr = output['external_ip_address_db']['value']

    result

    result = {
        '_meta': {
            'hostvars': {
                app_addr: {
                    'ansible_python_interpreter': python3
                },
                db_addr: {
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
                app_addr
            ]
        },
        'dbserver': {
            'hosts': [
                db_addr
            ]
        }
    }

    res_string = json.dumps(result, sort_keys=True, indent=4, separators=(',', ': '))

    with open(os.path.join(current_path, inventory_file), mode='w+') as file:
        file.write(res_string)
        print(res_string)

    exit(0)

else:
    print 'No --list argument was provided'
    exit(-1)
