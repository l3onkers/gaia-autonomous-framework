# Governance Modules

This folder stores governed private package artifacts used by shared setup and build bundles.

## Angular UI components fallback

The `angular/` subdirectory contains a stub UI component library tarball that serves as the default fallback when the primary package registry is unavailable.

### Replacing with your own component library

To use your own corporate component library:

1. Build your component library as a tarball (`.tgz`):
   ```bash
   cd your-component-library/
   npm pack
   ```

2. Place the output tarball in `./angular/` and name it `ui-components-stub-1.0.0.tgz` (or update references across the repository to match your filename).

### Using from an app

Use your package registry by default:

```json
{
  "dependencies": {
    "@corp/ui-components": "~1.0.0"
  }
}
```

If the registry connection is unavailable, fall back to the governed tarball:

```json
{
  "dependencies": {
    "@corp/ui-components": "file:../.github/governance/modules/angular/ui-components-stub-1.0.0.tgz"
  }
}
```

Then run `npm install`.