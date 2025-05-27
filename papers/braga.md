```json
{
  "decisions": [
    {
      "model": "generalized additive Poisson regression",
      "variable": "daily deaths",
      "method": "LOESS",
      "parameter": "smoothing parameter",
      "type": "parameter",
      "reason": "to eliminate seasonal patterns in the residuals and to reduce the residuals of the regression to “white noise”",
      "decision": "NA",
      "reference": "braga2001lag"
    },
    {
      "model": "generalized additive Poisson regression",
      "variable": "temperature",
      "method": "NA",
      "parameter": "smoothing parameter",
      "type": "parameter",
      "reason": "to allow for city-specific differences",
      "decision": "NA",
      "reference": "NA"
    },
    {
      "model": "generalized additive Poisson regression",
      "variable": "relative humidity",
      "method": "NA",
      "parameter": "smoothing parameter",
      "type": "parameter",
      "reason": "to allow for city-specific differences",
      "decision": "NA",
      "reference": "NA"
    },
    {
      "model": "generalized additive Poisson regression",
      "variable": "barometric pressure",
      "method": "NA",
      "parameter": "smoothing parameter",
      "type": "parameter",
      "reason": "to allow for city-specific differences",
      "decision": "NA",
      "reference": "NA"
    },
    {
      "model": "distributed lag model",
      "variable": "PM10",
      "method": "NA",
      "parameter": "lag",
      "type": "temporal",
      "reason": "NA",
      "decision": "1-day lag",
      "reference": "NA"
    },
        {
      "model": "distributed lag model",
      "variable": "PM10",
      "method": "NA",
      "parameter": "lag",
      "type": "temporal",
      "reason": "NA",
      "decision": "2-day moving average",
      "reference": "NA"
    }
  ]
}
```
