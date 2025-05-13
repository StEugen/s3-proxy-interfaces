import { createProxyMiddleware } from 'http-proxy-middleware';

export default function (app) {
  app.use(
    '/upload',
    createProxyMiddleware({
      target: 'http://localhost:8080',
      changeOrigin: true,
    }),
  );
}
