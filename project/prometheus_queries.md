## Availability SLI
### The percentage of successful requests over the last 5m
```
100 * sum by (job)(increase(flask_http_request_total{status=~"2.."}[5m])) / sum by (job)(increase(flask_http_request_total[5m]))
```

## Latency SLI
### 90% of requests finish in these times
```
histogram_quantile(0.9, sum(rate(flask_http_request_duration_seconds_bucket[5m])) by (le, job))
```

## Throughput
### Successful requests per second
```
sum by (job)(rate(flask_http_request_total{status=~"2.."}[1m]))
```


## Error Budget - Remaining Error Budget
### The error budget is 20%
```
1 - sum by (job)(increase(flask_http_request_total{status!~"2.."}[1d])) / (0.2 * sum by (job)(increase(flask_http_request_total[1d])))
```

