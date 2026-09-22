import pluginVue from 'eslint-plugin-vue'
import { includeIgnoreFile } from "@eslint/compat";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const gitignorePath = path.resolve(__dirname, ".gitignore");

export default [
  // add rulesets here
  ...pluginVue.configs['flat/recommended'],
  includeIgnoreFile(gitignorePath),
  {
    rules: {
      // disabling v-html warning b/c we provide all injected html
      'vue/no-v-html': 'off'
    }
  }
]
