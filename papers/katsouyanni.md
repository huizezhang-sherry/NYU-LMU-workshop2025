```json
{
  "decisions": [
    {
      "model": "generalized additive model",
      "variable": "seasonal patterns and long-term trends",
      "method": "LOESS",
      "parameter": "smoothing parameter",
      "type": "parameter",
      "reason": "NA",
      "decision": "smoothing window should not be below 2 months",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "temperature",
      "method": "smoothing function",
      "parameter": "degrees of freedom",
      "type": "parameter",
      "reason": "done by minimizing Akaike's information criterion",
      "decision": "NA",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "relative humidity",
      "method": "smoothing function",
      "parameter": "degrees of freedom",
      "type": "parameter",
      "reason": "done by minimizing Akaike's information criterion",
      "decision": "NA",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "temperature",
      "method": "NA",
      "parameter": "NA",
      "type": "temporal",
      "reason": "NA",
      "decision": "same day and of lags up to 2 days or averaged over 0 to 2 days",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "relative humidity",
      "method": "NA",
      "parameter": "NA",
      "type": "temporal",
      "reason": "NA",
      "decision": "same day and of lags up to 2 days or averaged over 0 to 2 days",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "PM10",
      "method": "NA",
      "parameter": "NA",
      "type": "temporal",
      "reason": "based on previous studies having shown those lags to be the most relevant",
      "decision": "average of lags 0 and 1",
      "reference": "NA"
    },
    {
      "model": "generalized additive model",
      "variable": "black smoke",
      "method": "NA",
      "parameter": "NA",
      "type": "temporal",
      "reason": "based on previous studies having shown those lags to be the most relevant",
      "decision": "average of lags 0 and 1",
      "reference": "NA"
    }
  ]
}
```
