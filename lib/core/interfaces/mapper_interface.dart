abstract class Mapper<Input, Output> {
  Output mapTo(Input input);

  Input mapFrom(Output output);
}
