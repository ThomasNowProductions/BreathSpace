# BreathSpace Website

This is a simple web interface for handling deep links to the BreathSpace mobile app.

## Features

- **App-Exact Design**: Matches the exact design, theme, and layout of the BreathSpace mobile app
- **Authentic Theme**: Uses the same white background, black text, and GFS Didot font as the app
- **Welcome Screen**: Features the exact same "Welcome to BreathSpace" title and subtitle as the app
- **Theme-Accurate Buttons**: Black "Get Started" and "Open in App" buttons matching the app's ElevatedButton styling, properly centered and visible on main page
- **Deep Link Handling**: Detects exercise IDs from URLs and attempts to open the mobile app
- **Mobile Detection**: Automatically detects mobile devices and tries to launch the app
- **Fallback Experience**: Shows exercise information and app download links if the app isn't available
- **Responsive Design**: Works well on both desktop and mobile browsers
- **Copy Link Functionality**: Users can copy exercise links to clipboard for easy sharing

## URL Structure

The website handles URLs in the format:
- `https://breathspace.vercel.app/exercise/{exerciseId}`
- `https://breathspace.vercel.app/?exercise={exerciseId}`

## How It Works

1. **Mobile Users**: The site tries to open the BreathSpace app using the custom URL scheme `breathspace://exercise/{exerciseId}`
2. **Desktop Users**: Shows a web version of the exercise with links to download the mobile app
3. **Fallback**: If the app doesn't open on mobile, shows exercise details and app store links
4. **Copy Link**: Users can copy exercise links to clipboard for easy sharing across any platform

## Exercise Data

The website includes a subset of the most popular breathing exercises from the mobile app. The full exercise database is maintained in the mobile app's `assets/exercises.json`.

## Deployment

This website should be deployed to handle the domain `breathspace.vercel.app` to properly support the deep linking functionality.
</content>
</html>