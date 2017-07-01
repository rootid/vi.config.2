#!/usr/bin/env python

import json
import sys
import os
from sets import Set

def resolve_dependency(path):
    dep_files = set()
    dep_files.add(path)
    prefix_path = os.path.dirname(path)

    def dfs(path):
      #print path
      with open(path, 'r') as f:
        data = json.load(f)
        dep_files.add(path)
        if('properties' in data) :
            props = data['properties'].keys()
            child_path = ''
            for prop in props:
                #print data['properties'][prop]
                if ('$ref' in data['properties'][prop].keys()):
                    child_path = data['properties'][prop]['$ref']
                elif ('items' in data['properties'][prop].keys()) :
                    child_path = data['properties'][prop]['items']['$ref']
                if child_path not in dep_files and len(child_path) > 1 :
                  next_path = prefix_path + '/' + str(child_path)
                  dep_files.add(next_path)
                  dfs(next_path)
    dfs(path)
    print list(dep_files)
    return list(dep_files)

#resolve_dependency('./target/json-schemas/schema/v2/customer/terms_and_conditions_data.json')
resolve_dependency(sys.argv[1])
