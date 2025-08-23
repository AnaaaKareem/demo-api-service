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

app.listen(PORT, () => console.log(`It's alive on http://localhost:${PORT}`));