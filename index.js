import express from 'express';
import routeAuth    from './app/routes/routes.auth.js';
import routeUsuario from './app/routes/routes.usuario.js';

const app = express();
const PORT = 3000;

// Middleware para parsear JSON
app.use(express.json());

// Ruta de prueba
app.get('/', (req, res) => {
  res.json({ message: 'Servidor funcionando correctamente' });
});

// Rutas de autenticación PRIMERO (no requieren token)
app.use('/api', routeAuth);

// Rutas del CRUD (protegidas con JWT)
app.use('/api', routeUsuario);

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});