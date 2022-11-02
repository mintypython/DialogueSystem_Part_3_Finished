#macro TEXT new TextAction
#macro SPEAKER new SpeakerAction
#macro CHOICE new ChoiceAction
#macro OPTION new OptionAction
#macro GOTO new GotoAction

function DialogueAction() constructor {
	act = function() { };
}

// Define new text to type out
function TextAction(_text) : DialogueAction() constructor {
	text = _text;

	act = function(textbox) {
		textbox.setText(text);
	}
}

// Set the speaker, optionally its portrait and side the portrait is on
function SpeakerAction(_name, _sprite = undefined, _side = undefined): DialogueAction() constructor {
	name = _name;
	sprite = _sprite;
	side = _side;

	act = function(textbox) {
		textbox.speaker_name = name;
		
		if (!is_undefined(sprite))
			textbox.portrait_sprite = sprite;
			
		if (!is_undefined(side))
			textbox.portrait_side = side;
			
		textbox.next();
	}
}

// Define a branch in the dialogue
function ChoiceAction(_text) : DialogueAction() constructor {
	text = _text;

	// Fill this array with all the arguments after the first one
	options = [];
	for (var i = 1; i < argument_count; i++)
		array_push(options, argument[i]);

	act = function(textbox) {
		textbox.setText(text);
		textbox.options = options;
		textbox.option_count = array_length(options);
		textbox.current_option = 0;
	}
}

// Place options within the ChoiceAction
function OptionAction(_text, _topic): DialogueAction() constructor {
	text = _text;
	topic = _topic;

	act = function(textbox) {
		textbox.setTopic(topic);
	}
}

// Automatically go to a specified topic
function GotoAction(_topic): DialogueAction() constructor {
	topic = _topic;

	act = function(textbox) {
		textbox.setTopic(topic);
	}
}