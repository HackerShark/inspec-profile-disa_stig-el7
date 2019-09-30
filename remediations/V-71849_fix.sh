#!/bin/bash
rpm -Va | grep '^.M' | awk 'NF>1{print $NF}' | while read line ; do
   echo rpm -qf $line
   package_needed="$(rpm -qf $line)"
   echo "Fixing Package ${package_needed}"
   echo "rpm --setperms ${package_needed}"
   "$(rpm --setperms ${package_needed})"
   echo "rpm --setugids ${package_needed}"
   "$(rpm --setugids ${package_needed})"
done
