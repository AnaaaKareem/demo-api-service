const app = require('express');
const PORT = 8080;

app.get('/', (req, res) => {
    res.status(200).send({
        Meesage: 'Hello',
        Description: 'This is an API made by Karim Khater'
    })
});

app.get('/health', (req, res) => {
    res.status(200).send({
        status: 'ok',
        deployed_by: 'Karim Khater'
    })
});

app.listen(
    PORT,
    () => console.log(`it's alive on http://localhost:${PORT}`)
)