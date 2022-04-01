#/bash/sh

# get total number of items with trait
bgTotalTraitO=0
baseApeTotal=0
clothesTotal=0
earringsTotal=0
eyesTotal=0
headWearTotal=0
mouthTotal=0
rosesTotal=0
necklaceTotal=0
cryptoTotal=0

# get total supply
tokenNumber=$(curl -X GET "https://explorer.emerald.oasis.dev/api?module=token&action=getToken&contractaddress=0xA011Ad0c02259019B0a8eF1c6f818191a031adA9" -H "accept: application/json" | jq '.result.totalSupply')
echo $tokenNumber

# loop through all items metadata to get totals
for file in *
do
    echo "Processing $file"
    filename=$(basename "$file")
    
    if [ "$filename" != "metadata-edit.sh" ]
    then
        echo "Editing $filename"
        echo "$(jq '.attributes' $filename)"
        sample="$(jq '.attributes' $filename)"
        echo $sample
        for row in $(echo "${sample}" | jq -r '.[] | @base64'); do
            _jq() {
                echo ${row} | base64 --decode | jq -r ${1}
            }
            

        traitType=$(_jq '.trait_type')
        traitValue=$(_jq '.value')
        if [ "$traitType" == "0_BG" ] && [ $traitValue == "1" ]
        then
            echo "BG trait found"
            bgTotalTraitO=$(($bgTotalTraitO+1))
        fi
        done 
    fi

done

echo $bgTotalTraitO



# persist the total and use it to calculate rarity
echo "  {
        total: $tokenNumber,
        traitsTotal: {
            bgTotalTraitO: $bgTotalTraitO,
            }
        }" > bgTotalTraitO.json

# Another method used to calculate NFT rarity is averaging the rarity of traits that exist on the NFT. 
# For example, if an NFT had 2 traits, one with 50% rarity and another with 10% rarity, it's average trait rarity is (50+10)/2 = 30%. 
# The method seems good since at least it considers the overall rarity of the traits.


# Rarity Score for a Trait Value = 1 / ([Number of Items with that Trait Value] / [Total Number of Items in Collection]) = 

# Trait BG = 1 / 21 / 1000 = 0.000001800180018 
# Trait AP = 1 / 1 / 1000 = 0.0001800180018

# Rarity = 0.000001800180018
