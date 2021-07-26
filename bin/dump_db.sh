#!/bin/bash
set -eu

export MIX_ENV=${1:-dev}

/usr/bin/mysqldump -h mariadb -u root -proot nano_planner_${MIX_ENV} > /apps/nano_planner/tmp/nano_planner_${MIX_ENV}.sql
