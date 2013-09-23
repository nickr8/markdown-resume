#!/usr/bin/env ruby

require 'kramdown'
require 'pdfkit'

if ARGV.empty?
  puts "Which file do you want to turn into a resume PDF?
The command should look like this: 'ruby mdresume.rb exampleresume.md'
Please correct and try again"
  exit
end

css = "
<html>
<head>
<style type='text/css'>

html{
margin: 2em 3em;
}

h1{
font-family:'Arial Black',sans-serif;
font-size: 1.3em;
text-transform: uppercase;
font-weight: bold;
color: #E20058;
border-style: dotted none dotted none;
padding: 0.2em 0;
margin: 1em 0 0.5em 0;
letter-spacing: 0.02em}

a{text-decoration:none;color:black;}
p{
font-family: 'Lucida Grande',sans-serif;
font-size: 0.8em;
}

strong {font-family:'Helvetica';font-weight: 900;text-transform: uppercase;}

</style>
</head>"

markdownFile = File.read(ARGV.join" ")

htmlFile = Kramdown::Document.new(markdownFile).to_html
htmlFile = css << htmlFile <<  "</html>"

kit = PDFKit.new(htmlFile)
pdf = kit.to_pdf

file = kit.to_file('resume.pdf')

system("open resume.pdf")

puts "SUCCESS!!! You now have a nice resume in PDF form. If you want to make changes just change your markdown file and run the script again."
