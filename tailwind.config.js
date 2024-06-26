const defaultTheme = require("tailwindcss/defaultTheme")
const plugin = require("tailwindcss/plugin")

const colorPalette = {
  "coral-red": {
    50: "#FFECEC",
    100: "#FFD9D9",
    200: "#FFC3C3",
    300: "#FFB9B9",
    400: "#FF9C9C",
    500: "#FF8D8D",
    600: "#FF6767",
    700: "#FF4141",
    800: "#CC3434",
    900: "#992727",
  },
  midnight: {
    50: "#EAEFFA",
    100: "#C8D3F2",
    200: "#A5B7E9",
    300: "#829CE1",
    400: "#5F80D9",
    500: "#3D64D1",
    600: "#2C51B7",
    700: "#234194",
    800: "#1B3271",
    900: "#050915",
  },
  "glitter-lake": {
    50: "#F2FAFF",
    100: "#E6F5FF",
    200: "#CCEBFF",
    300: "#B3E2FF",
    400: "#99D8FF",
    500: "#80CEFF",
    600: "#66A5CC",
    700: "#4D7C99",
    800: "#335266",
    900: "#1A2933",
  },
  amaranth: {
    50: "#FEF4F7",
    100: "#FDE4EA",
    200: "#FBCAD6",
    300: "#F7A0B5",
    400: "#F5819D",
    500: "#F36C8C",
    600: "#F1577C",
    700: "#EE2D5B",
    800: "#CD0736",
    900: "#AB062D",
  },
  "middle-green": {
    50: "#F6FAF7",
    100: "#E3F0E6",
    200: "#C7E1CC",
    300: "#B4D7BC",
    400: "#A1CEAB",
    500: "#8FC49A",
    600: "#60AB70",
    700: "#449C56",
    800: "#17742B",
    900: "#000000",
  },
}

module.exports = {
  prefix: "pulse-",
  content: [
    "./app/components/**/*.{slim,rb,js,css}",
    "./app/views/**/*.{erb,slim,js}",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./app/lib/form_builders/**/*.rb",
    "./previews/**/*.rb",
  ],
  theme: {
    container: {
      center: true,
      padding: "0.625rem",
    },
    extend: {
      boxShadow: {
        btn: "0 4px 6px 0 rgb(0, 0, 0, 0.3)",
        "btn-inset": "inset 0 0 0 3px var(--pulse-fgColor-onEmphasis)",
      },
      colors: {
        ...colorPalette,
        current: "currentColor",
        transparent: "transparent",
        primary: {
          DEFAULT: colorPalette["coral-red"][700],
          ...colorPalette["coral-red"],
        },
        secondary: {
          DEFAULT: colorPalette["midnight"][700],
          ...colorPalette["midnight"],
        },
        tertiary: {
          DEFAULT: colorPalette["glitter-lake"][700],
          ...colorPalette["glitter-lake"],
        },
        error: {
          DEFAULT: colorPalette["amaranth"][700],
          ...colorPalette["amaranth"],
        },
        success: {
          DEFAULT: colorPalette["middle-green"][700],
          ...colorPalette["middle-green"],
        },
        danger: {
          DEFAULT: colorPalette["amaranth"][700],
          ...colorPalette["amaranth"],
        },
      },
      fontFamily: {
        sans: ["Nunito Sans", ...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        "2xs": "0.625rem" /* 10px */,
      },
    },
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/forms", {
      strategy: "base", // only generate global styles
    }),
    require("@tailwindcss/typography"),
    plugin(function ({ addVariant }) {
      addVariant("peer-unchecked", ".peer:not(:checked) ~ &")
    }),
  ],
}
