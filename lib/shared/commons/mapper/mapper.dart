/// [Mapper] is an abstract class that defines the methods to convert a model to an entity and vice versa.
abstract class Mapper<M, E> {
  /// Converts a model object to an entity object.
  E toEntity(M model);

  /// Converts an entity object to a model object.
  M toModel(E entity);
}
