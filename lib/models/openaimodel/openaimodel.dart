class Openaimodel {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choice>? choices;
  Usage? usage;

  Openaimodel({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
  });

  factory Openaimodel.fromJson(Map<String, dynamic> json) => Openaimodel(
        id: json['id'] as String?,
        object: json['object'] as String?,
        created: json['created'] as int?,
        model: json['model'] as String?,
        choices: (json['choices'] as List<dynamic>?)
            ?.map((e) => Choice.fromJson(e as Map<String, dynamic>))
            .toList(),
        usage: json['usage'] == null
            ? null
            : Usage.fromJson(json['usage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'created': created,
        'model': model,
        'choices': choices?.map((e) => e.toJson()).toList(),
        'usage': usage?.toJson(),
      };
}

class Choice {
  String? text;
  int? index;
  dynamic logprobs;
  String? finishReason;

  Choice({this.text, this.index, this.logprobs, this.finishReason});

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json['text'] as String?,
        index: json['index'] as int?,
        logprobs: json['logprobs'] as dynamic,
        finishReason: json['finish_reason'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'index': index,
        'logprobs': logprobs,
        'finish_reason': finishReason,
      };
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json['prompt_tokens'] as int?,
        completionTokens: json['completion_tokens'] as int?,
        totalTokens: json['total_tokens'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'prompt_tokens': promptTokens,
        'completion_tokens': completionTokens,
        'total_tokens': totalTokens,
      };
}
