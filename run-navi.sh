#!/bin/bash
cd `xcrun simctl get_app_container booted com.farfetch.NaviDemo data` \
&& cd Documents \
&& browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 9000
