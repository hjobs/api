curl -X POST \
-H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbXBsb3llcl9pZCI6MSwiZXhwIjoxNDg4ODk0MDM0fQ.QWN4_MKNNqo4MZY4QuAP_1tpLZnw0o4SIno8fg8NELc' \
-H 'content-type: application/json' \
-d '{"job": {"title": "Created with Curl", "periods": [{"start_time": "2017-04-06T14:00:16.994Z", "end_time": "2017-04-07T14:00:16.994Z"}], "locations": [{"address": "random address"}], "employement_types": ["fulltime"], "job_type": 1}}' \
-i http://localhost:9080/employer/jobs
