---
name: Acoustic Aura
colors:
  surface: '#131317'
  surface-dim: '#131317'
  surface-bright: '#39393d'
  surface-container-lowest: '#0e0e12'
  surface-container-low: '#1b1b1f'
  surface-container: '#1f1f23'
  surface-container-high: '#2a292e'
  surface-container-highest: '#353439'
  on-surface: '#e4e1e7'
  on-surface-variant: '#e6bdbc'
  inverse-surface: '#e4e1e7'
  inverse-on-surface: '#303034'
  outline: '#ad8887'
  outline-variant: '#5d3f3f'
  surface-tint: '#ffb3b2'
  primary: '#ffb3b2'
  on-primary: '#680013'
  primary-container: '#ff525e'
  on-primary-container: '#5b0010'
  inverse-primary: '#bf002c'
  secondary: '#ffb2b7'
  on-secondary: '#67001c'
  secondary-container: '#d00242'
  on-secondary-container: '#ffe1e2'
  tertiary: '#ffb3af'
  on-tertiary: '#68000d'
  tertiary-container: '#ff5354'
  on-tertiary-container: '#5c000a'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffdad9'
  primary-fixed-dim: '#ffb3b2'
  on-primary-fixed: '#410008'
  on-primary-fixed-variant: '#92001f'
  secondary-fixed: '#ffdadb'
  secondary-fixed-dim: '#ffb2b7'
  on-secondary-fixed: '#40000e'
  on-secondary-fixed-variant: '#91002b'
  tertiary-fixed: '#ffdad7'
  tertiary-fixed-dim: '#ffb3af'
  on-tertiary-fixed: '#410005'
  on-tertiary-fixed-variant: '#930017'
  background: '#131317'
  on-background: '#e4e1e7'
  surface-variant: '#353439'
typography:
  display-lyrics-active:
    fontFamily: Inter
    fontSize: 34px
    fontWeight: '700'
    lineHeight: 42px
  display-lyrics-active-mobile:
    fontFamily: Inter
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 34px
  display-lyrics-inactive:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '600'
    lineHeight: 40px
  display-lyrics-inactive-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  title-sm:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 22px
  body-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
  caption-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-tablet: 1.5rem
  gutter-desktop: 2rem
  margin: 1.25rem
  margin-tablet: 2rem
  margin-desktop: 3rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.25rem
---

## Brand & Style
This design system captures an immersive, audio-first experiential aesthetic derived from premium mobile media playback environments. The interface prioritizes musical content over chrome, treating every view as an emotional visual extension of the album artwork. 

The aesthetic fuses fluid Glassmorphism with deep, ambient dynamic backdrops. By projecting blurred, undulating gradients derived from cover art across an ultra-dark canvas, the UI feels alive and responsive. The emotional response is intimate, atmospheric, and high-fidelity, designed to make users feel entirely submerged in sound and poetic typography.

## Colors
The color architecture relies on an ultra-deep charcoal neutral base (`#0D0D11`) overlayed with real-time extracted dynamic color fields. The system default accents leverage vibrant Apple-inspired audio crimsons (`#FA2D48` and `#FF375F`), used sparingly for active states, interactive scrub heads, and primary feedback loops.

### Layering & Dynamic Blend Logic
- **Background Base:** Pitch-dark ambient neutral (`#0D0D11`) to prevent light bleed and maintain battery efficiency on OLED displays.
- **Ambient Chromatic Gradients:** 3 to 4 extracted artwork hues projected via radial gradients with dynamic 80px–120px Gaussian blurs, animated subtly via hardware-accelerated transforms.
- **Surface Overlays:** Pure white with variable alpha transparency tiers:
  - High Emphasis / Primary Glyphs: `rgba(255, 255, 255, 0.95)`
  - Secondary Info / Track Artists: `rgba(255, 255, 255, 0.64)`
  - Inactive Lyrics / Tertiary Labels: `rgba(255, 255, 255, 0.30)`
  - Frosted Control Bases: `rgba(255, 255, 255, 0.12)`
  - Dividers / Subtle Outlines: `rgba(255, 255, 255, 0.08)`

## Typography
Typographic selection uses Inter for its structural resemblance to Apple's native San Francisco Neo-grotesque geometry: neutral, highly legible at micro-sizes, and commanding at massive display scales.

### Time-Synced Lyric Typographic Rules
- **Active Lyric State:** Set to `display-lyrics-active`, rendered in `rgba(255, 255, 255, 1.0)` with a subtle text shadow glow (`0 0 24px rgba(255, 255, 255, 0.35)`). Active lines scale smoothly to 100% scale while retaining sharp rendering.
- **Inactive / Background Lyric State:** Set to `display-lyrics-inactive`, rendered at `rgba(255, 255, 255, 0.28)`, with a soft blur filter (`filter: blur(1.5px)`) to direct visual depth squarely onto the spoken line.
- **Transitions:** Line changes use spring-driven animations (`cubic-bezier(0.2, 0.8, 0.2, 1.0)`) across color, blur, and scale over 350ms.

## Layout & Spacing
The layout leverages an edge-to-edge full bleed structure designed for portrait mobile experiences and side-by-side adaptive panels on larger screens.

### Spatial Systems
- **Mobile (Phone):** Single-column stacked layout. The viewport is divided vertically: 50% dynamic lyrics view / artwork hero, 18% scrubber and meta block, 20% minimalist transport controls, and 12% bottom-docked utility actions (Lyrics, AirPlay, Up Next) anchored directly above safe bottom insets.
- **Tablet / Split View:** 2-column asymmetric fluid grid: 45% left-pane pinned for album artwork and global transport; 55% right-pane scrollable lyrics feed.
- **Desktop:** Floating center modal player (max-width: 960px) bounded by dynamic frosted backdrops, or wide multi-column layout with 2rem gutters.

## Elevation & Depth
Depth is established through translucent physical materials and optical refraction rather than synthetic drop shadows.

- **Background Canvas:** Level 0. Continuous fluid multi-stop mesh gradient based on track artwork, overlaid with a runtime CSS backdrop-filter blur (`60px–90px`).
- **Glass Sheets & Bottom Bar:** Level 1. Background `rgba(255, 255, 255, 0.08)`, backdrop-filter `blur(30px) saturate(180%)`, border `1px solid rgba(255, 255, 255, 0.12)`.
- **Interactive Controls & Scrub Head:** Level 2. Solid white glyphs floating with faint directional ambient bounce (`box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3)`).
- **Lyric Focus:** Foreground optical isolation. Active lines sit on visual level 3, popping above the inactive text plane using scale transforms (`scale(1.03)`) and negative blur.

## Shapes
The shape language is organic, frictionless, and pill-dominant, matching iOS tactile design patterns.

- **Buttons & Chips:** Completely pill-shaped (`border-radius: 9999px`) to invite natural thumb interactions.
- **Album Art & Overlays:** Soft nested squircle radii (`rounded-lg` through `rounded-xl`) matching native device display contours.
- **Scrubber / Volume Sliders:** 4px default tracks expanding to 8px during user scrubbing, with perfectly circular thumb handles.

## Components

### Playback Controls
- **Transport Bar:** Center-anchored group consisting of Previous, Play/Pause, and Next.
- **Play/Pause Toggle:** High-contrast fluid touch target. Minimum dimension 64x64px. White icon with scale spring physics on release (`scale(0.92)` on press, snapping back to `1.0`).
- **Secondary Skips:** Ghost circular actions, sized at 44x44px, filled with `rgba(255, 255, 255, 0.85)`.

### Scrubber & Sliders
- **Timeline Rail:** Dual-tone horizontal track. Inactive track rendered in `rgba(255, 255, 255, 0.15)`; elapsed track rendered in pure solid white or track primary accent.
- **Scrubbing Feedback:** Small circular pip (10px diameter) that expands to 16px upon continuous touch, displaying dynamic timestamp bubble directly overhead.

### Action Bar (Bottom Sheet)
- **Container:** Horizontally spaced layout anchored at the bottom edge containing three key utilities: Lyrics Mode toggle, AirPlay selector, and Up Next Queue.
- **Active Toggle State:** Pill badge housing the icon with active white frosted background (`rgba(255, 255, 255, 0.22)`) and high-luminosity foreground icon.
- **Inactive State:** Unadorned icon tinted to `rgba(255, 255, 255, 0.54)`.

### Live Lyrics Stream
- **Container:** Vertically scrollable view with scroll-snap alignment to active line.
- **Interaction:** Tapping any inactive lyric instantaneously scrubs the track to that precise timestamp, accompanied by an instant typographic transition and subtle haptic feedback.
- **Vocal Runs & Backing Vocals:** Rendered as secondary indented lines in slightly smaller tracking (`label-md`), fading in asynchronously.

### Cards & Track Listings
- **Queue Row:** 56px height, rounded corners (`rounded-md`), frosted glass background hover/active states (`rgba(255, 255, 255, 0.06)`). Includes track artwork thumbnail (40x40px, `rounded-sm`), primary track title in `title-sm`, and artist/album in `caption-sm`.