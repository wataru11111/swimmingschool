const { environment } = require('@rails/webpacker')

// Webpack 5 以降では `node` オプションを手動で設定しない
// 必要であれば、'false' を指定して無効化
environment.config.set('node', false)

module.exports = environment
