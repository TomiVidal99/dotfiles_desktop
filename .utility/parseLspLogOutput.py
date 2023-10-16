import re

with open("/home/tomii/.local/state/nvim/lsp.log", "r") as file:
    log_content = file.read()

log_entries = re.split(r"\n(?=\[\w+\])", log_content)
formatted_entries = []

for entry in log_entries:
    lines = entry.strip().split("\n")
    formatted_entry = []

    for line in lines:
        if re.match(r"\[\w+\]", line):
            formatted_entry.append(line)
        else:
            if line.startswith("[ERROR]"):
                # Format the [ERROR] section with correct indentation
                formatted_entry.append(line)
            else:
                formatted_entry[-1] += "\n" + line

    formatted_entries.append("\n".join(formatted_entry))

for entry in formatted_entries:
    print(entry)
