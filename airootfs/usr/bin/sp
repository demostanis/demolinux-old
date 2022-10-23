#!/usr/bin/env ruby

require 'uri'
require 'net/http'

episodes = {}
if ARGV[0] then
  # -e 1-10  =  from season 1 to 10
  # -e 1.13  =  season 1 episode 13
  # -e 1-12,14-24.1  =  everything but season 13 and last episode
  ARGV[0].split(',').each do |sel|
    if sel.include? '-' then
      start, endd = sel.split('-')
      if start.include? '.' then
        start_season, start_episode = start.split('.').map(&:to_i)
        end_season, end_episode = endd.split('.').map(&:to_i)
        raise if start_season > end_season || (start_season == end_season && start_episode >= end_episode)

        if start_season == end_season then
          episodes[start_season] = start_episode..end_episode
        else
          (start_season+1..end_season-1).each do |season|
            episodes[season] = 0..
          end
          episodes[start_season] = start_episode..;
          episodes[end_season] = 0..end_episode
        end
      else
        start = start.to_i
        endd = endd.to_i
        raise if start >= endd
        (start..endd).each do |i| episodes[i] = 0.. end
      end
    else
      if sel.include? '.' then
        season, episode = sel.split('.').map(&:to_i)
        (episodes[season] ||= []) << episode
      else
        episodes[sel.to_i] = 0..
      end
    end
  end
end

print 'Downloading '
to_download = episodes.sort.to_h
puts 'everything' if to_download.empty?
to_download.each_pair do |season, episodes|
  if episodes == (0..) then
    print "entire season #{season}"
  elsif episodes.kind_of?(Range) then
    print "season #{season} from #{episodes.begin ? 'episode '+episodes.begin.to_s : 'beginning'} to #{episodes.end ? 'episode '+episodes.end.to_s : 'end'}"
  else
    ep = [*episodes].join(', ').sub(/,[^,]+$/, 'and')
    print "episodes #{ep} in season #{season}"
  end
  if [season, episodes] == to_download.to_a.last then
    puts '.'
  else
    print ', '
  end
end

uri = URI 'https://www.south-park-tv.biz/'
res = Net::HTTP.get uri
res
  .scan(/<a class="ubermenu-target[^"]+" href="([^"]+)"><span class="ubermenu-target-title[^"]+">([^<]+)<\/span><\/a>/)
  .each do |url, name|
    if name =~ /(?:Saison \d+ )?Episode (\d+)/ then
      if $episode.nil? || $1.to_i < $episode
        $season ||= 0
        $season += 1
      end
      $episode = $1.to_i

      if episodes.empty? || (episodes[$season] && episodes[$season].include?($episode)) then
        episode = sprintf "%.2d", $1
        link = URI "https://www.south-park-tv.biz/storage7869876976/southpark#{$season}x#{episode}.mp4"

        Net::HTTP.start(link.host, link.port, :use_ssl => true) do |client|
          total = client.head(link, { 'Referer' => url })['Content-Length'].to_i
          print "Downloading season \033[1m#{$season}\033[0m, episode \033[1m#{$episode}\033[0m:     "
          counter = 0

          dir = "Saison #{$season}"
          Dir.mkdir(dir) if not Dir.exists? dir
          file = "#{dir}/Episode #{episode}.mp4"

          File.open(file, 'w') do |f|
            client.get(link, { 'Referer' => url }) do |buf|
              f.write(buf)
              counter += buf.length
              backspaces = "\b" * (($percentage || 100).to_s.length + 1)
              $percentage = (counter.to_f / total.to_f * 100).to_i
              print "#{backspaces}\033[32;1m#{$percentage}%\033[0m"
            end
          end

          puts "\b\b\b\b\033[32mdone\033[0m"
        end
      end
    end
  end
