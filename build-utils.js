const fs = require('fs');

switch (process.argv[2]) {
    case '--enable-debug-opt': {
        const path = process.argv[3];
        let content = fs.readFileSync(path, { encoding: 'utf8' });

        content = content
            .replace('<BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>',
                     '<BasicRuntimeChecks>Default</BasicRuntimeChecks>')

            .replace('<InlineFunctionExpansion>Disabled</InlineFunctionExpansion>',
                     '<InlineFunctionExpansion>AnySuitable</InlineFunctionExpansion>')

            .replace('<Optimization>Disabled</Optimization>',
                     '<Optimization>MinSpace</Optimization>');

        fs.writeFileSync(path, content);
        break;
    }
}
