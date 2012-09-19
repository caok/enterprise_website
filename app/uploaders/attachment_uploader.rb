# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # 处理由于carrierwave不支持unicode引起的文件名称乱码问题Ruby1.9
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  # Ruby1.8
  #CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Zа-яА-ЯёЁ0-9\.\-\+_]/u


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type

  #version :thumb, :if => :image? do
    #process :resize_to_fit => [500, 300]
  #end

  protected
  def image?(new_file)
    new_file.content_type.include? 'image'
  end
end
