var avail = 4000;
var total = 0;

var items = process.argv.slice(2)

for (var i = 0; i < items.length; i++) {
    total += items[i].length;
}

if (total === 0) {
    process.stderr.write('Nothing to repeat\n');
    process.exit(1);
}

for (var i = 0; ; i = (i + 1) % items.length) {
    if (avail < items[i].length) {
        break;
    }
    process.stdout.write(items[i]);
    avail -= items[i].length;
}
