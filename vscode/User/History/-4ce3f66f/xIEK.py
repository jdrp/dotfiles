import os
import xml.etree.ElementTree as ET

def get_xml_files(directory):
    """Get a list of all XML files in the specified directory."""
    return [f for f in os.listdir(directory) if f.endswith('.xml')]

def read_xml_file(file_path):
    """Read and parse an XML file, returning its text content."""
    try:
        tree = ET.parse(file_path)
        return ET.tostring(tree.getroot(), encoding='unicode')
    except ET.ParseError as e:
        print(f"Error parsing {file_path}: {e}")
        return ""

def main():
    reports_dir = 'reports'  # Directory containing XML files
    output_file = 'combined_reports.txt'  # Output text file

    # Get all XML files in the reports directory
    xml_files = get_xml_files(reports_dir)

    # Open the output file once and write contents of each XML file
    with open(output_file, 'w', encoding='utf-8') as file:
        for xml_file in xml_files:
            file_path = os.path.join(reports_dir, xml_file)
            xml_content = read_xml_file(file_path)

            # Write file name and its content to the text file
            file.write(f"File: {xml_file}\n{xml_content}\n\n")

    print(f"Combined report saved to {output_file}")

if __name__ == "__main__":
    main()