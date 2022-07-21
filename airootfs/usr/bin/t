#!/bin/zsh
target_language=${${1:-EN}:u}
args=${@:2}
word=${args:-`cat`}
from=${from:-auto}

# Map language codes to language names
# It is required to use dict.deepl.com
declare -A languages
languages[EN]="english"
languages[DE]="german"
languages[FR]="french"
languages[ES]="spanish"
languages[IT]="italian"
languages[NL]="dutch"
languages[PL]="polish"
languages[RU]="russian"
languages[PT]="portuguese"
languages[JA]="japanese"
languages[ZH]="chinese"

echo -e "  \x1b[1mTRANSLATIONS:\x1b[0m"
timestamp=`echo $(date +%s)000`
response=`curl -s 'https://www2.deepl.com/jsonrpc?method=LMT_handle_jobs' -H 'Content-type: application/json' --data-raw '{"jsonrpc":"2.0","method": "LMT_handle_jobs","params":{"jobs":[{"kind":"default","raw_en_sentence":"'"$word"'","raw_en_context_before":[],"raw_en_context_after":[],"preferred_num_beams":4}],"lang":{"preference":{"weight":{},"default":"default"},"source_lang_user_selected":"'"$from"'","target_lang":"'"$target_language"'"},"priority":1,"commonJobParams":{},"timestamp":'$timestamp'},"id":20319097}'`
echo "$response" | jq -r "if has(\"result\") then .result.translations[].beams[].postprocessed_sentence else .error.message end" | sed 's/\.//g' | tr '[:upper:]' '[:lower:]' | awk '!seen[$0]++'

echo -e "  \x1b[1mEXAMPLES:\x1b[0m"
language_source=${languages[`echo "$response" | jq -r ".result.source_lang"`]}
language_target=${languages[`echo "$response" | jq -r ".result.target_lang"`]}
examples=`curl -s "https://dict.deepl.com/$language_source-$language_target/search?ajax=1&source=$language_source&onlyDictEntries=1&translator=dnsof7h3k2lgh3gda&delay=300&jsStatus=0&kind=select&eventkind=click&forleftside=true" --data "query=$word" | xmllint --html --xpath '//*[@class="example_lines"]/*/*/span[not(@class="dash")]/text()' - 2>/dev/null | paste -d '>' - - | sed 's/>/ => /g'`
IFS=$'\n'
for example in $examples; do echo $example; done
[ x = "x$examples" ] && echo None.

