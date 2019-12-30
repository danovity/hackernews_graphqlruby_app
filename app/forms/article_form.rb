class ArticleForm
  # == Constants ============================================================

  # == Attributes ===========================================================

  attr_accessor :article

  # == Extensions ===========================================================

  include ActiveModel::Model

  # == Relationships ========================================================

  # == Validations ==========================================================

  # validates :target, numericality: { less_than_or_equal_to: 99_999_999, greater_than_or_equal_to: 100 }
  # validate :validate_ends_on
  # validates :postal_code, postal_code_format: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  def initialize(article, params = {})
    self.article = article
    params = {} if params.nil?
    self.assign_attributes(params)
  end

  def assign_attributes(params)
    if params['section'].present?
      section_type = params.delete('section')
      assign_section(section_type)
    elsif params[:section].present?
      section_type = params.delete(:section)
      assign_section(section_type)
    end

    params.each do |key, value|
      self.class.module_eval { attr_accessor :"#{key}" }
      self.send("#{key}=", value)
      self.article.send("#{key}=", value)
    end

    self.article.attributes.except(:id, :created_at).each do |key, value|
      self.class.module_eval { attr_accessor :"#{key}" }
      self.send("#{key}=", value)
    end
  end

  def form_fields_valid?
    valid = self.valid? && self.article.valid?
    merge_errors if !valid
    valid
  end

  def save
    if self.form_fields_valid?
      save_object
      self
    else
      false
    end
  end

  def assign_section(section_type)
    case section_type
    when 'top'
      self.article.top_story = true
    when 'best'
      self.article.best_story = true
    when 'new'
      self.article.new_story = true
    else
      return
    end
  end

  private

  def save_object
    self.article.save!
  end

  def merge_errors
    self.article.errors.messages.each do |field, messages|
      messages.each { |message| errors.add(field, message) }
    end
  end
end
