# Design Guide

This document outlines the design principles, color scheme, typography, and UI components used in the BreathSpace application.

## Table of Contents

- [Design Principles](#design-principles)
- [Color Scheme](#color-scheme)
- [Typography](#typography)
- [UI Components](#ui-components)
- [Layout Guidelines](#layout-guidelines)
- [Iconography](#iconography)
- [Accessibility](#accessibility)

## Design Principles

BreathSpace follows these core design principles:

1. **Simplicity**: Clean, uncluttered interface that focuses on the breathing exercise
2. **Calmness**: Design elements that promote relaxation and mindfulness
3. **Consistency**: Uniform design language across all screens
4. **Accessibility**: Clear contrast and readable text for all users
5. **Intuitiveness**: Easy-to-understand navigation and interactions

## Color Scheme

### Light Theme

- **Background**: `Colors.white` (#FFFFFF)
- **Primary**: `Colors.black` (#000000)
- **Card Background**: `Colors.grey[200]` (#EEEEEE)
- **Text**: `Colors.black` (#000000)
- **Secondary Text**: `Colors.black` with 70% opacity (#000000B3)
- **Hint Text**: `Colors.black` with 50% opacity (#00000080)

### Dark Theme

- **Background**: `Colors.black` (#000000)
- **Primary**: `Colors.white` (#FFFFFF)
- **Card Background**: `Colors.grey[900]` (#121212)
- **Text**: `Colors.white` (#FFFFFF)
- **Secondary Text**: `Colors.white` with 70% opacity (#FFFFFFB3)
- **Hint Text**: `Colors.white` with 50% opacity (#FFFFFF80)

### Breathing Visualization

- **Light Theme Bubble**: `ColorScheme.secondary` (black)
- **Dark Theme Bubble**: `ColorScheme.secondary` (white)

## Typography

### Font Family

BreathSpace uses the "GFS Didot" font family for all text elements. This elegant serif font promotes a sense of calm and sophistication.

### Text Styles

- **Headings**: `headlineMedium` from ThemeData
- **Body Text**: `bodyLarge` and `bodyMedium` from ThemeData
- **Captions**: Default TextStyle with smaller font size
- **Buttons**: Default ElevatedButton text style

### Font Sizes

- **App Bar Titles**: Default AppBar title size
- **Screen Headings**: `headlineMedium` (typically 24-34sp)
- **Body Text**: `bodyLarge` (typically 16-20sp)
- **Secondary Text**: `bodyMedium` (typically 14-16sp)
- **Captions**: 12-14sp
- **Buttons**: Default ElevatedButton size

## UI Components

### AppBar

- Background color matches scaffold background
- Contains a search bar in a Card component
- Settings icon in the top right corner

### Cards

- **Elevation**: 0 (flat design)
- **Border Radius**: 12.0
- **Margin**: 16.0 horizontal, 8.0 vertical
- **Background**: Theme.cardColor (changes with theme)

### Buttons

#### ElevatedButton

- **Background**: Theme.primaryColor
- **Text Color**: Theme.onPrimary
- **Border Radius**: Default Material radius
- **Padding**: Default Material padding

#### Icon Buttons

- **Size**: 24
- **Color**: Theme.onSurface

### List Items

- **ListTile** components for exercise listings
- **Padding**: 16.0 all around
- **Spacing**: 8.0 vertical between items

### Text Fields

- **Search Bar**: TextField inside a Card with rounded corners
- **Border**: InputBorder.none (no visible border)
- **Cursor Color**: Theme.onSurface
- **Hint Text**: Theme.onSurface with 50% opacity

## Layout Guidelines

### Spacing

- **Screen Padding**: 16.0
- **Component Spacing**: 8.0-16.0
- **Section Spacing**: 24.0

### Screen Structure

1. **App Bar** (if applicable)
2. **Main Content Area**
3. **Action Button** (usually at bottom)

### Responsive Design

- Use `MediaQuery` for responsive sizing
- Ensure adequate touch targets (minimum 48x48 pixels)
- Test on various screen sizes

## Iconography

### Icons Used

- **Settings**: `Icons.settings_outlined`
- **Search**: Built-in TextField hint
- **Navigation**: Standard Material icons

### Icon Guidelines

- **Size**: 24 for action icons
- **Color**: Theme.onSurface
- **Placement**: Consistent throughout the app

## Accessibility

### Color Contrast

- Maintain minimum 4.5:1 contrast ratio for text
- Use sufficient contrast between background and UI elements

### Text Scaling

- Support system text scaling
- Test with largest accessibility text sizes

### Touch Targets

- Minimum 48x48 pixels for interactive elements
- Adequate spacing between touch targets

### Semantic Labels

- Provide semantic labels for all interactive elements
- Use proper heading hierarchy for screen readers