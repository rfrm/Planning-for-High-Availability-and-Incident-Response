## Availability SLI
### The percentage of successful requests over the last 5m
```
100 * sum without(pid, status)(increase(flask_http_request_total{status=~"2.*"}[5m])) / sum without(pid, status) (increase(flask_http_request_total[5m]))
```

## Latency SLI
### 90% of requests finish in these times
```
histogram_quantile(0.90, sum(rate(flask_http_request_duration_seconds_bucket[5m])) by (le))
```

## Throughput
### Successful requests per second
```
sum without(pid)(rate(flask_http_request_total{status=~"2.."}[5m]))
```


## Error Budget - Remaining Error Budget
### The error budget is 20%
```
1 - ((1 - (sum(increase(flask_http_request_total{status="200"}[7d])) by (method)) / sum(increase(flask_http_request_total[7d])) by (method)) / (1 - .80))
```

