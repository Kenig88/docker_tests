FROM python:latest

# Рабочая директория
WORKDIR /app

# Копируем зависимости и тест
COPY requirements.txt .
COPY tests/test_main.py .

# Устанавливаем Python-зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем системные зависимости и Google Chrome (БЕЗ apt-key)
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
 && wget -q -O /usr/share/keyrings/google-linux-signing-keyring.gpg \
    https://dl.google.com/linux/linux_signing_key.pub \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-keyring.gpg] \
    http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update \
 && apt-get install -y google-chrome-stable \
 && rm -rf /var/lib/apt/lists/*

# Папка для Allure
RUN mkdir allure-results

# Запуск тестов
CMD ["pytest", "test_main.py", "--alluredir=allure-results"]
