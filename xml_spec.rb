
require "./macbeth_analyzer"

RSpec.describe Speaker do
    it "A speaker starts with no lines " do
        person = Speaker.new
        expect(person.lines).to eq(0)
    end
end

RSpec.describe Speaker do
    it "Person name is Malcom" do
        person = Speaker.new
        person.name = "Malcom"
        expect(person.name).to eq("Malcom")
    end
end

sample_xml_1 = <<EOM
<PLAY>
    <TITLE>Some play</TITLE>
    <ACT>
        <SCENE>
            <SPEECH>
                <SPEAKER>Person 1</SPEAKER>
                <LINE>I have said 1 line</LINE>
                <LINE>I have said 2 line</LINE>
                <LINE>I have said 3 line</LINE>
                <LINE>I have said 4 line</LINE>
                <LINE>I have said 5 line</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Person 2</SPEAKER>
                <LINE>I have said 1 line</LINE>
                <LINE>I have said 2 line</LINE>
            </SPEECH>
        </SCENE>
        <SCENE>
            <SPEECH>
                <SPEAKER>ALL</SPEAKER>
                <LINE>This line doesnt count</LINE>
                <LINE>This line doesnt count</LINE>
                <LINE>This line doesnt count</LINE>
            </SPEECH>
        </SCENE>
    </ACT>
</PLAY>
EOM

RSpec.describe "parse xml" do
    it "should ignore Lines with speaker ALL" do
        speakers = parse_XML(sample_xml_1)

        expect(speakers.size).to eq(2)
        expect(speakers[0].lines).to eq(5)
        expect(speakers[1].lines).to eq(2)
    end
end

sample_xml_2 = <<EOM
<PLAY>
    <TITLE>Some play</TITLE>
    <ACT>
        <SCENE>
            <SPEECH>
                <SPEAKER>Person 1</SPEAKER>
                <LINE>I have said 1 line</LINE>
                <LINE>I have said 2 line</LINE>
                <LINE>I have said 3 line</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Person 2</SPEAKER>
                <LINE>I have said 1 line</LINE>
                <LINE>I have said 2 line</LINE>
            </SPEECH>
        </SCENE>
        <SCENE>
            <SPEECH>
                <SPEAKER>ALL</SPEAKER>
                <LINE>This line doesnt count</LINE>
                <LINE>This line doesnt count</LINE>
                <LINE>This line doesnt count</LINE>
            </SPEECH>
        </SCENE>
    </ACT>
    <ACT>
        <SCENE>
            <SPEECH>
                <SPEAKER>Person 1</SPEAKER>
                <LINE>I have said 4 line</LINE>
                <LINE>I have said 5 line</LINE>
                <LINE>I have said 6 line</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Person 3</SPEAKER>
                <LINE>I have said 1 line</LINE>
                <LINE>I have said 2 line</LINE>
                <LINE>I have said 3 line</LINE>
            </SPEECH>
        </SCENE>
    </ACT>
</PLAY>
EOM

RSpec.describe "parse xml" do
    it "should count the correct number of lines a speaker says" do
        speakers = parse_XML(sample_xml_2)

        expect(speakers.size).to eq(3)
        expect(speakers[0].lines).to eq(6)
        expect(speakers[1].lines).to eq(2)
        expect(speakers[2].lines).to eq(3)
    end
end

RSpec.describe "parse xml" do
    it "should put the correct name of the speaker in the array" do
        speakers = parse_XML(sample_xml_2)

        expect(speakers.size).to eq(3)
        expect(speakers[0].name).to eq("Person 1")
        expect(speakers[1].name).to eq("Person 2")
        expect(speakers[2].name).to eq("Person 3")
    end
end
