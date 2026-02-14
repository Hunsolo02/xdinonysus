# Установка конфигурации на CachyOS (KDE Plasma + Hyprland)

Эта конфигурация рассчитана на **Hyprland** (Wayland). На CachyOS с KDE Plasma вы можете поставить Hyprland рядом: при входе в систему выбирать сессию **Plasma** или **Hyprland**.

---

## 1. Установка пакетов

Установите зависимости (CachyOS основан на Arch):

```bash
# Hyprland и база
sudo pacman -S hyprland hyprpaper xdg-desktop-portal-hyprland

# Терминал, лаунчер, панель, виджеты
sudo pacman -S alacritty rofi waybar eww cava

# Утилиты (звук, яркость, скриншоты, буфер)
sudo pacman -S pipewire pipewire-pulse wireplumber wpctl playerctl brightnessctl grim slurp wl-clipboard

# Остальное (файлы, браузер, датчики — по желанию)
sudo pacman -S thunar firefox lm-sensors curl
```

Опционально (для скриншотов и блокировки):

```bash
sudo pacman -S grim slurp  # уже выше
# Блокировка экрана в Hyprland (если нужен hyprlock):
sudo pacman -S hyprlock
```

Шрифты (для Waybar/Rofi):

```bash
sudo pacman -S ttf-jetbrains-mono-nerd gohu-font
```

---

## 2. Размещение конфигов

Клонируйте репозиторий (если ещё не клонирован) и создайте симлинки из `dotfiles` в `~/.config`:

```bash
# Предполагается, что репозиторий лежит в ~/xdinonysus (или ваш путь)
cd ~/xdinonysus  # или где у вас лежит репозиторий

# Бэкап существующих конфигов (если есть)
mkdir -p ~/.config-backup
for d in alacritty cava eww hypr neofetch rofi waybar; do
  [ -d ~/.config/$d ] && mv ~/.config/$d ~/.config-backup/$d
done

# Симлинки на папки из dotfiles
ln -sfn "$(pwd)/dotfiles/alacritty"   ~/.config/alacritty
ln -sfn "$(pwd)/dotfiles/cava"         ~/.config/cava
ln -sfn "$(pwd)/dotfiles/eww"          ~/.config/eww
ln -sfn "$(pwd)/dotfiles/hypr"         ~/.config/hypr
ln -sfn "$(pwd)/dotfiles/neofetch"     ~/.config/neofetch
ln -sfn "$(pwd)/dotfiles/rofi"         ~/.config/rofi
ln -sfn "$(pwd)/dotfiles/waybar"       ~/.config/waybar
```

Если хотите копировать конфиги вместо симлинков:

```bash
cp -r dotfiles/alacritty dotfiles/cava dotfiles/eww dotfiles/hypr \
      dotfiles/neofetch dotfiles/rofi dotfiles/waybar ~/.config/
```

Zsh (опционально):

```bash
ln -sfn "$(pwd)/dotfiles/zsh/.zshrc" ~/.zshrc
```

---

## 3. Что поправить под свой ПК

### Звук (Cava)

В `~/.config/cava/config` в секции `[input]` укажите свой источник PulseAudio/PipeWire, например:

```ini
[input]
method = pulse
source = auto
```

Или найдите монитор вывода: `pactl list short sources` и подставьте нужный.

### Firefox

В `~/.config/hypr/hyprland.conf` закомментируйте или удалите строку с `exec-once = hyprctl dispatch exec '[workspace 9 silent] firefox ...'`, либо замените путь к профилю на свой (например, из `~/.mozilla/firefox/`).

### Модули Waybar (ASUS / NordVPN)

- Если у вас не ноутбук ASUS — в `~/.config/waybar/config` закомментируйте или уберите модули `custom/asus-profile` и связанные скрипты.
- Если не используете NordVPN — уберите или закомментируйте `custom/vpn` в `config` и соответствующие скрипты.

### Клавиатура и блокировка (не ASUS)

В `hyprland.conf` закомментируйте или удалите привязки к `XF86KbdBrightness*`, `XF86Launch3`, `XF86Launch4` и строки с `~/.config/hypr/scripts/asus-kbd/` и `~/.config/kbd-brightness.sh`, если таких клавиш/скриптов нет.  
Блокировка: если не ставите hyprlock, закомментируйте привязку на `~/.config/hyprlock/lock.sh` или замените на свою команду блокировки.

---

## 4. Сессия Hyprland при входе

Обычно на CachyOS с KDE используется **SDDM**. После установки Hyprland в меню входа должна появиться сессия **«Hyprland»**.

1. Выйдите из текущей сессии (или перезагрузитесь).
2. На экране входа SDDM выберите пользователя.
3. Внизу или в меню выберите сессию: **Plasma (X11)** / **Plasma (Wayland)** или **Hyprland**.
4. Введите пароль и войдите.

Тогда KDE Plasma остаётся по умолчанию, а эта конфигурация используется только когда вы выбираете сессию Hyprland.

---

## 5. Проверка после входа в Hyprland

- **Waybar** и **EWW** запускаются из `waybar_watcher.sh` при старте Hyprland.
- Терминал: **Alt+T** (если не меняли привязки).
- Лаунчер: **Alt+Space** (Rofi).
- Громкость/яркость: клавиши Fn или XF86* (если не отключили в конфиге).

Если Waybar или EWW не появляются, откройте Alacritty и запустите вручную:

```bash
waybar &
eww open-many bar  # или как у вас настроены окна eww
```

Проверьте логи: `journalctl -b -u hyprland` или вывод в терминале при запуске `waybar` и `eww`.

---

## Кратко

| Шаг | Действие |
|-----|----------|
| 1 | Установить пакеты: hyprland, waybar, eww, rofi, alacritty, cava и утилиты (см. выше). |
| 2 | Сделать симлинки (или копии) из `dotfiles/*` в `~/.config/`. |
| 3 | Подправить cava (источник звука), при желании — Firefox, убрать ASUS/NordVPN из waybar. |
| 4 | Войти в сессию **Hyprland** с экрана входа SDDM. |

KDE Plasma при этом не трогается — вы просто выбираете другую сессию при входе.
