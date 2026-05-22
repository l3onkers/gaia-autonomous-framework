# UI Components Stub

This directory should contain the fallback tarball for the corporate UI component library.

## Current state

The proprietary component library has been removed. To use this framework:

1. **Option A** — Use a public component library (e.g., Angular Material, PrimeNG, etc.)
2. **Option B** — Build your own component library and place the `.tgz` here

### Creating a minimal stub

```bash
# Create a minimal Angular library
mkdir ui-components-stub && cd ui-components-stub
npm init -y --name="@corp/ui-components" --version="1.0.0"

# Add a minimal index.ts
echo "export class UiComponentsModule {}" > index.ts

# Pack it
npm pack
# Move the resulting .tgz to this directory
mv corp-ui-components-1.0.0.tgz ../ui-components-stub-1.0.0.tgz
cd .. && rm -rf ui-components-stub
```

### Component selector prefix

All components in this framework use the `corp-` selector prefix (e.g., `corp-card`, `corp-button`, `corp-table`). When integrating your own library, map your component selectors to the `corp-` prefix or update the references in the skills.
