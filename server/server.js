const express = require('express');
const app = express();
const PORT = 8080;

app.get('/', (req, res) => {
    res.status(200).send({
        Message: 'Hello',
        Description: 'This is an API made by Karim Khater'
    });
});

app.get('/health', (req, res) => {
    res.status(200).send({
        status: 'ok',
        deployed_by: 'Karim Khater'
    });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
