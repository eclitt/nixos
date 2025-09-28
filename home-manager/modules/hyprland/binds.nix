{ pkgs, ... }:
let
  changeWallpaperScript = pkgs.writeShellScriptBin "change-wallpaper" ''
    #!/usr/bin/env bash
    
    # Configuration
    WALLPAPER_DIR="$HOME/Pictures/Wallpapers/normal"
    CACHE_DIR="$HOME/.cache/wallpaper-selector"
    THUMBNAIL_WIDTH="250"
    THUMBNAIL_HEIGHT="141"
    
    # Create cache directory if it doesn't exist
    mkdir -p "$CACHE_DIR"

    # Function to generate thumbnail
    generate_thumbnail() {
        local input="$1"
        local output="$2"
        magick "$input" -thumbnail "''${THUMBNAIL_WIDTH}x''${THUMBNAIL_HEIGHT}^" -gravity center -extent "''${THUMBNAIL_WIDTH}x''${THUMBNAIL_HEIGHT}" "$output"
    }

    # Create shuffle icon thumbnail with Nerd Fonts icon
    SHUFFLE_ICON="$CACHE_DIR/shuffle_thumbnail.png"

    # Создаем иконку с символом из Nerd Fonts ( - иконка перемешивания)
    magick -size "''${THUMBNAIL_WIDTH}x''${THUMBNAIL_HEIGHT}" xc:'#1a1a1a' \
        -font "${pkgs.nerd-fonts.symbols-only}/share/fonts/truetype/NerdFonts/Symbols/SymbolsNerdFont-Regular.ttf" \
        -pointsize 60 -fill white -gravity center -annotate +0+0 "" \
        "$SHUFFLE_ICON"

    # Generate thumbnails and create menu items
    generate_menu() {
        # Add random/shuffle option
        echo -en "img:$SHUFFLE_ICON\x00info:!Random Wallpaper\x1fRANDOM\n"
        
        # Then add all wallpapers
        for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
            # Skip if no matches found
            [[ -f "$img" ]] || continue
            
            # Generate thumbnail filename
            thumbnail="$CACHE_DIR/$(basename "''${img%.*}").png"
            
            # Generate thumbnail if it doesn't exist or is older than source
            if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
                generate_thumbnail "$img" "$thumbnail"
            fi
            
            # Output menu item
            echo -en "img:$thumbnail\x00info:$(basename "$img")\x1f$img\n"
        done
    }

    # Check if wallpaper directory exists
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        notify-send "Wallpaper Error" "Wallpaper directory not found: $WALLPAPER_DIR"
        exit 1
    fi

    # Use wofi to display grid of wallpapers
    selected=$(generate_menu | wofi --show dmenu \
        --cache-file /dev/null \
        --define "image-size=''${THUMBNAIL_WIDTH}x''${THUMBNAIL_HEIGHT}" \
        --columns 3 \
        --allow-images \
        --insensitive \
        --sort-order=default \
        --prompt "Select Wallpaper" \
        --conf ~/.config/wofi/wallpaper.conf \
        --style ~/.config/wofi/wallpaper.css \
      )

    # Set wallpaper if one was selected
    if [ -n "$selected" ]; then
        # Remove the img: prefix to get the cached thumbnail path
        thumbnail_path="''${selected#img:}"

        # Check if random wallpaper was selected
        if [[ "$thumbnail_path" == "$SHUFFLE_ICON" ]]; then
            # Select a random wallpaper from the directory
            original_path=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
        else
            # Get the original filename from the thumbnail path
            original_filename=$(basename "''${thumbnail_path%.*}")
            
            # Find the corresponding original file
            original_path=$(find "$WALLPAPER_DIR" -type f -name "''${original_filename}.*" | head -n1)
        fi

        # Ensure a valid wallpaper was found
        if [ -n "$original_path" ] && [ -f "$original_path" ]; then
            # Set wallpaper using hyprpaper
            hyprctl hyprpaper unload all
            hyprctl hyprpaper reload ,"$original_path"
            
            # Save the selection for persistence
            mkdir -p "$(dirname "$HOME/.cache/current_wallpaper")"
            echo "$original_path" > "$HOME/.cache/current_wallpaper"

            # Notify user
            notify-send "Wallpaper" "Wallpaper has been updated to $(basename "$original_path")" -i "$original_path"
        else
            notify-send "Wallpaper Error" "Could not find the original wallpaper file."
        fi
    fi
  '';
in
{
  home.packages = [ changeWallpaperScript ];
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Launch Terminal
      "$mainMod,       Return, exec, $terminal"
      # Launch Firefox
      "$mainMod,       B, exec, firefox"
      # Launch Filemanager
      "$mainMod,       E, exec, $fileManager"
      "$mainMod SHIFT, E, exec, kitty ranger"
      # Launch Telegramm
      "$mainMod,       T, exec, AyuGram"
      # Launch Program menu
      "$mainMod,       Space, exec,pkill $menu || $menu --show drun"
      # Lock System
      "$mainMod,       L, exec, hyprlock"
      "$mainMod SHIFT, L, exit"
      # Screenshot
      "$mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only"
      "$mainMod SHIFT CONTROL, S, exec, hyprshot -m region"
      # Fullscreen
      "$mainMod,       F, fullscreen, 1"
      "$mainMod SHIFT, F, fullscreen, 0"

      # Wallpaper script
      "$mainMod,       Z, exec, ${changeWallpaperScript}/bin/change-wallpaper"
      
      # Cliphistory
      "$mainMod,       V, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

      # Standart hyprland Binds
      "$mainMod,       W, killactive,"
      "$mainMod,       N, togglefloating,"
      "$mainMod,       J, togglesplit,"
      "$mainMod,       P, pseudo,"

      # Moving focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Moving windows
      "$mainMod SHIFT, left,  swapwindow, l"
      "$mainMod SHIFT, right, swapwindow, r"
      "$mainMod SHIFT, up,    swapwindow, u"
      "$mainMod SHIFT, down,  swapwindow, d"

      # Resizeing windows                   X  Y
      "$mainMod CTRL, left,  resizeactive, -60 0"
      "$mainMod CTRL, right, resizeactive,  60 0"
      "$mainMod CTRL, up,    resizeactive,  0 -60"
      "$mainMod CTRL, down,  resizeactive,  0  60"

      # Switching workspaces
      #"$mainMod, 1, workspace, 1"
      #"$mainMod, 2, workspace, 2"
      #"$mainMod, 3, workspace, 3"
      #"$mainMod, 4, workspace, 4"
      #"$mainMod, 5, workspace, 5"
      #"$mainMod, 6, workspace, 6"
      #"$mainMod, 7, workspace, 7"
      #"$mainMod, 8, workspace, 8"
      #"$mainMod, 9, workspace, 9"
      #"$mainMod, 0, workspace, 10"

      # Moving windows to workspaces
      #"$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      #"$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      #"$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      #"$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      #"$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      #"$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      #"$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      #"$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      #"$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      #"$mainMod SHIFT, 0, movetoworkspacesilent, 10"

      # Magic workspace
      "$mainMod,       X, togglespecialworkspace,  magic"
      "$mainMod SHIFT, X, movetoworkspace, special:magic"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
    ];

    # Audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}
