#!/bin/bash

# Step 1: Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Step 2: Create the lebron.js script
echo "Creating lebron.js script..."

cat << 'EOF' > lebron.js
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// function to compile lebron code into js
function compileLebronCode(filePath) {
    let fileContent;
    try {
        fileContent = fs.readFileSync(filePath, 'utf-8');
    } catch (err) {
        console.error('Error reading file:', err);
        process.exit(1);
    }

    // replace Lebron keywords with js
    let compiledCode = fileContent;

    compiledCode = compiledCode
        .replace(/lebronSays/g, 'console.log')
        .replace(/functionalyAGod\s+(\w+)\s+roster:\s*([\w,\s]*)\s*{/g, 'function $1($2) {')
        .replace(/lebronPassesItBack/g, 'return')
        .replace(/untilHesBenched/g, 'for')
        .replace(/untilTheBuzzer/g, 'while')
        .replace(/kingJamesHoldsCourt/g, 'if')
        .replace(/leboobooJamesTriesAgain/g, 'else if')
        .replace(/anotherChanceToDominate/g, 'else')
        .replace(/letHimCookNow/g, 'let')
        .replace(/constantlyTheGoat/g, 'const')
        .replace(/lebronStopsThePlay/g, 'break')
        .replace(/lebronPushesForward/g, 'continue')
        .replace(/subHimInCoach/g, 'switch')
        .replace(/hesSynchronizedWithTheGame/g, 'async')
        .replace(/waitForTheEtherealLebrobroJamesToFinishHisPlay/g, 'await')
        .replace(/heDontHaveToTryCauseHesLikeThat/g, 'try')
        .replace(/catchThatBallLikeTheGoatHeIs/g, 'catch')
        .replace(/randomPlay/g, 'Math.random()')
        .replace(/roundDownMyDearestSir/g, 'Math.floor')
        .replace(/roundUpMyDearestSir/g, 'Math.ceil');

    // return the compiled javascript code
    return compiledCode;
}

function translateLebronCode(filePath) {
    let fileContent;
    try {
        fileContent = fs.readFileSync(filePath, 'utf-8');
    } catch (err) {
        console.error('Error reading file:', err);
        process.exit(1);
    }

    // replace Lebron keywords with js
    let compiledCode = fileContent;

    compiledCode = compiledCode
        .replace(/console.log/g, 'lebronSays')
        .replace(/function\s+(\w+)\s*\(([\w,\s]*)\)\s*{/g, 'functionalyAGod $1 roster: $2 {')
        .replace(/return/g, 'lebronPassesItBack')
        .replace(/for/g, 'untilHesBenched')
        .replace(/while/g, 'untilTheBuzzer')
        .replace(/if/g, 'kingJamesHoldsCourt')
        .replace(/else if/g, 'leboobooJamesTriesAgain')
        .replace(/else/g, 'anotherChanceToDominate')
        .replace(/let/g, 'letHimCookNow')
        .replace(/const/g, 'constantlyTheGoat')
        .replace(/break/g, 'lebronStopsThePlay')
        .replace(/continue/g, 'lebronPushesForward')
        .replace(/switch/g, 'subHimInCoach')
        .replace(/async/g, 'hesSynchronizedWithTheGame')
        .replace(/await/g, 'waitForTheEtherealLebrobroJamesToFinishHisPlay')
        .replace(/try/g, 'heDontHaveToTryCauseHesLikeThat')
        .replace(/catch/g, 'catchThatBallLikeTheGoatHeIs')
        .replace(/Math.random\(\)/g, 'randomPlay')
        .replace(/Math.floor/g, 'roundDownMyDearestSir')
        .replace(/Math.ceil/g, 'roundUpMyDearestSir');


    // return the compiled javascript code
    return compiledCode;
}





if (process.argv[2] === '-c') { // compile lebron code
    // get the file path from the command-line argument
    const filePath = process.argv[3];
    if (!filePath) {
        console.error('Please provide a file path');
        process.exit(1);
    }

    // ensure the file has the `.lebron` extension
    if (!filePath.endsWith('.lebron')) {
        console.error('The file must have a .lebron extension');
        process.exit(1);
    }

    // compile the code and run it
    const compiledCode = compileLebronCode(filePath);
    try {
        const func = new Function(compiledCode);
        func();  // Executes the compiled JavaScript code
    } catch (err) {
        console.error('Error executing the compiled code:', err);
    }
} else if (process.argv[2] === '-tjs') { // translate to javascript
    const fromFile = process.argv[3]; // file we are sending code from
    const toFile = process.argv[4]; // file we are translating to 
    
    if (!fromFile || !toFile) {
        console.error('Please provide a file path');
        process.exit(1);
    }
    if (!fromFile.endsWith('.lebron')) {
        console.error('The file you are sending code from must have a .lebron extension');
        process.exit(1);
    }
    if (!toFile.endsWith('.js')) {
        console.error('The file you are sending code to must have a .js extension');
        process.exit(1);
    }

    const translatedCode = compileLebronCode(fromFile);
    try {
        fs.writeFileSync(toFile, translatedCode);
        console.log(`Successfully translated ${fromFile} to ${toFile}`);
    }
    catch (err) {
        console.error(err);
    }
} else if (process.argv[2] === '-tlb') { // translate to lebron
    const fromFile = process.argv[3]; // file we are sending code from
    const toFile = process.argv[4]; // file we are translating to 
    
    if (!fromFile || !toFile) {
        console.error('Please provide a file path');
        process.exit(1);
    }
    if (!fromFile.endsWith('.js')) {
        console.error('The file you are sending code from must have a .js extension');
        process.exit(1);
    }
    if (!toFile.endsWith('.lebron')) {
        console.error('The file you are sending code to must have a .lebron extension');
        process.exit(1);
    }

    const translatedCode = translateLebronCode(fromFile);
    try {
        fs.writeFileSync(toFile, translatedCode);
        console.log(`Successfully translated ${fromFile} to ${toFile}`);
    }
    catch (err) {
        console.error(err);
    }
} else {
    console.error("Invalid argument/parameter type");
    process.exit(1);
}
EOF

# Step 3: Make the lebron.js script executable
chmod +x lebron.js

# Step 4: Install lebron command in ~/bin/
INSTALL_DIR="$HOME/bin"

# Create bin directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Move the lebron.js script to ~/bin/ as lebron command
mv lebron.js "$INSTALL_DIR/lebron"

# Step 5: Add ~/bin to PATH if it's not already included
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "Adding $INSTALL_DIR to PATH..."
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
    echo "Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc'."
fi

# Step 6: Verify the installation
if command -v lebron &> /dev/null; then
    echo "lebron command installed successfully."
else
    echo "Failed to install the lebron command. Please check your path configuration."
    exit 1
fi

# Step 7: Success message
echo "You can now use the 'lebron' command to run your .lebron files."
echo "Usage: lebron <filename.lebron>"
