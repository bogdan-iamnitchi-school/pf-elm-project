import fs from 'fs';
import child_process from 'child_process';

const SEED = "376158560164992";

export function runTest(testCtx: boolean = false) {
    const args = [`--seed ${SEED}`];
    args.push(testCtx ? "--report console" : "--report json");
    const cmd = [process.platform == "win32" ? "npx.cmd elm-test" : "npx elm-test", ...args];
    const opts = {shell: true};
    const cmdStr = (cmd.join(' '));
    const testResult = child_process.spawnSync(cmdStr, opts);

    if (testCtx) {
        console.log(testResult.stdout.toString('utf-8'));
        console.log(testResult.stderr.toString('utf-8'));
    } else {
        if (!fs.existsSync("./logs")) {
            fs.mkdirSync("./logs");
        }
        fs.writeFileSync("./logs/test-logs.json", testResult.stdout);
        console.log("Saving test results in ./logs/test-logs.json");
        if (testResult.stderr.length != 0) {
            console.log("There were some errors! See ./logs/test-errs.log");
            fs.writeFileSync("./logs/test-errs.log", testResult.stderr);
        }
    }
    return testResult;
}

function main() {
    console.log("Testing");
    if (process.argv.length > 2) {
        if (process.argv[2] == 'test') {
            const res = runTest(true);
            process.exit(res.stderr.length === 0 ? 0 : -1);
        } 
    }
    const res = runTest(false);
    process.exit(res.stderr.length === 0 ? 0 : -1);
}

if (typeof require !== 'undefined' && require.main === module) {
    main();
}