# API Service

| Category     | SLI                                        | SLO                                                                                                         |
|--------------|--------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Availability |flask_http_request_total                    | 99%                                                                                                         |
| Latency      |flask_http_request_duration_seconds_bucket  | 90% of requests below 100ms                                                                                 |
| Error Budget |flask_http_request_total                    | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   |flask_http_request_total                    | 5 RPS indicates the application is functioning                                                              |
