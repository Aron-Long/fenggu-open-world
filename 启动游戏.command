#!/bin/bash
# 风与枫谷 · 本地服务器启动器
# 双击本文件即可启动游戏服务器（弹出的终端窗口不要关）

cd "$(dirname "$0")"

PORT=8000
# 若端口被占用自动换
while lsof -nP -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1; do
  PORT=$((PORT+1))
done

IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)

clear
echo "==============================================="
echo "   风 与 枫 谷 · 本地游戏服务器已启动"
echo "==============================================="
echo ""
echo "  💻 电脑浏览器打开："
echo "     http://127.0.0.1:$PORT/open-world-mobile-game.html"
echo ""
if [ -n "$IP" ]; then
echo "  📱 手机浏览器打开（需同一 WiFi）："
echo "     http://$IP:$PORT/open-world-mobile-game.html"
echo ""
fi
echo "  ⚠️  本终端窗口请保持打开，关闭即停止游戏"
echo "==============================================="
echo ""

# 自动打开浏览器（电脑端）
(sleep 1; open "http://127.0.0.1:$PORT/open-world-mobile-game.html") &

# 前台运行服务器（保持常驻）
exec /usr/bin/python3 -m http.server $PORT --bind 0.0.0.0
