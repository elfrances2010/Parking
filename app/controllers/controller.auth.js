import jwt from 'jsonwebtoken';

// Clave secreta (en producción usar process.env.JWT_SECRET)
const SECRET = 'mi_clave_secreta_123';

export const login = async (req, res) => {
  try {
    const { usuario, contraseña } = req.body;

    // Validación de credenciales (valores fijos para la guía)
    if (usuario !== 'admin' || contraseña !== '1234') {
      return res.status(401).json({ error: 'Credenciales incorrectas' });
    }

    // Generar token — NUNCA incluir contraseñas en el payload
    const token = jwt.sign({ usuario }, SECRET, { expiresIn: '2h' });

    res.json({ token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};