import mysql from 'mysql2/promise';

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',                   // vacía si usas XAMPP sin contraseña
  database: 'parking-backend',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

export default pool;