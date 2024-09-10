#!/bin/bash

# Перевіряємо, чи встановлений Python3
if ! command -v python3 &> /dev/null
then
    echo "Python3 не встановлено. Будь ласка, встановіть його перед запуском."
    exit
fi

# Перевіряємо версію Python
PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
REQUIRED_VERSION="3.11"

if [[ "$PYTHON_VERSION" != $REQUIRED_VERSION* ]]; then
    echo "Поточна версія Python ($PYTHON_VERSION) не відповідає вимогам ($REQUIRED_VERSION)."
    exit 1
else
    echo "Python $REQUIRED_VERSION вже встановлено."
fi

# Перевіряємо та створюємо віртуальне середовище (venv), якщо його немає
if [ ! -d "venv" ]; then
    echo "Створюємо нове віртуальне середовище 'venv'..."
    python3 -m venv venv
    echo "Virtual environment створено."
else
    echo "Віртуальне середовище 'venv' вже існує."
fi

# Активація venv
echo "Активуємо віртуальне середовище..."
source venv/bin/activate

# Перевірка та встановлення/оновлення pip, setuptools, і залежностей
echo "Перевіряємо встановлені пакети..."
pip install --upgrade pip \
 && pip install --upgrade setuptools \
 && pip install -r requirements.txt

# Запит у користувача, яку версію запустити (CLI чи UI)
echo "Виберіть режим запуску:"
echo "0) UI (за замовчуванням)"
echo "1) CLI"

read -p "Введіть 0 або 1 (або залиште порожнім для UI): " MODE

# Якщо користувач нічого не ввів, встановлюємо за замовчуванням значення 0 (UI)
MODE=${MODE:-0}

if [ "$MODE" == "1" ]; then
    echo "Запускаємо CLI версію..."
    python run_cli.py
elif [ "$MODE" == "0" ]; then
    echo "Запускаємо UI версію..."
    python run_ui.py
else
    echo "Невірний вибір. Будь ласка, введіть 0 або 1."
    exit 1
fi